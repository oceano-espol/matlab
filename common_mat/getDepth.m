function depth = getDepth(latitude, longitude)
%GETDEPTH Estimate seabed depth at specific location.
%   DEPTH = GETDEPTH(LATITUDE, LONGITUDE) estimates the seabed depth DEPTH
%   at specified coordinate(s). LATITUDE and LONGITUDE coordinates can
%   either be numeric arrays specifying decimal degrees or cell arrays of
%   strings specifying degrees, minutes, and seconds or GPS degrees. DEPTH
%   is returned in meters, where negative values correspond to depths below
%   sea level.
%
%   If LATITUDE and LONGITUDE are cell arrays of strings, the hemisphere
%   designator (N/S/E/W) must prepend the location (e.g. 'N 37 23 30') and
%   all values must be separated by spaces.
%
%   This function uses the Marine Geoscience Data System website to obtain
%   seabed estimates from their Global Multi-Resolution Topography (GMRT)
%   dataset. Thus, an Internet connection is required.
%
%   Example:
%       getDepth(32.930667, -117.3175)
%       getDepth('N 32 55 50', 'W 117 19 3')
%       getDepth('N 32 55.84', 'W 117 19.05')
%       getDepth([33.52 35.14], [-119.88 -123.35])
%       getDepth({'N 33 31 12' 'N 35 8 24'}, {'W 119 52 48' 'W 123 21 0'})
%       getDepth({'N 33 31.2' 'N 35 8.4'}, {'W 119 52.8' 'W 123 21.0'})
%
%   Reference:
%       Ryan, W.B.F., S.M. Carbotte, J.O. Coplan, S. O'Hara, A. Melkonian,
%       R. Arko, R.A. Weissel, V. Ferrini, A. Goodwillie, F. Nitsche, J.
%       Bonczkowski, and R. Zemsky (2009), Global Multi-Resolution
%       Topography synthesis, Geochem. Geophys. Geosyst., 10, Q03014, doi:
%       10.1029/2008GC002332

% Created by Josiah Renfree, May 16, 2016
% Advanced Survey Technologies / Southwest Fisheries Science Center
% National Oceanic and Atmospheric Administration

% Verify that two inputs were given
if nargin ~= 2
    error('Function requires two input arguments giving the GPS coordinates.')

% Verify that both inputs are the same type (e.g. both numeric arrays)
elseif ~strcmp(class(latitude), class(longitude))
    error('Both inputs must be of the same type, e.g. numeric arrays or cell arrays.')

% If inputs are single strings (i.e. not cell array), convert to cell
elseif ischar(latitude)
    latitude = {latitude};
    longitude = {longitude};

% Verify that both inputs are 1-D arrays of the same length
elseif (length(latitude) ~= length(longitude)) || min(size(latitude)) ~= 1
    error('Both inputs must be 1-D arrays of the same length.')
end

% If inputs are strings, convert to decimal degrees
if ~isnumeric(latitude)
    
    % Creaty empty arrays to hold results
    decLat = nan(length(latitude), 1);
    decLon = nan(length(latitude), 1);
    
    % Cycle through each input
    for i = 1:length(latitude)
        
        % Determine if input is in degrees/minutes/seconds or GPS format by
        % looking for period
        idx = strfind(latitude{i}, '.');
        
        % Parse using spaces
        tempLat = regexp(latitude{i}, ' ', 'split');
        tempLon = regexp(longitude{i}, ' ', 'split');

        % Verify that hemisphere designators are correct
        if ~any(strcmp(tempLat{1}, {'N', 'S'})) || ...
                ~any(strcmp(tempLon{1}, {'E', 'W'}))
            error('Missing hemisphere designator for input given.')
        end
            
        % If no period found, it is in degrees/minute/seconds
        if isempty(idx)
            
            % Verify that both returned 4 results
            if length(tempLat) ~= 4 || length(tempLon) ~= 4
                error('Incorrect format. Please check inputs.')      
            end
            
            % Convert to decimal degrees
            decLat(i) = str2double(tempLat{2}) + ...
                (str2double(tempLat{3}) + str2double(tempLat{4})/60) / 60;
            decLon(i) = str2double(tempLon{2}) + ...
                (str2double(tempLon{3}) + str2double(tempLon{4})/60) / 60;
            
        % If one period found, it is GPS format
        elseif length(idx) == 1
                        
            % Verify that both returned 3 results
            if length(tempLat) ~= 3 || length(tempLon) ~= 3
                error('Incorrect format. Please check inputs.')
            end
            
            % Convert to decimal degrees
            decLat(i) = str2double(tempLat{2}) + str2double(tempLat{3})/60;
            decLon(i) = str2double(tempLon{2}) + str2double(tempLon{3})/60;
            
        % If more than one period found, throw error
        else
            error('Unknown format. Please check inputs.')
        end
        
        % If Southern hemisphere, make negative
        if strcmpi(tempLat{1}, 's')
            decLat(i) = -1 * decLat(i);
        end
        
        % If Western hemisphere, make negative
        if strcmpi(tempLon{1}, 'w')
            decLon(i) = -1 * decLon(i);
        end
    end
    
% Otherwise, if inputs are numeric arrays, store in new variables for
% obtaining depth
else
    decLat = latitude;
    decLon = longitude;
end

% Cycle through each location and obtain depth
depth = nan(length(decLat), 1);
for i = 1:length(decLat)
    
    % Create URL string
    url = sprintf(['http://www.marine-geo.org/services/PointServer?' ...
        'latitude=%.5f&longitude=%.5f&format=text/plain'], ...
        decLat(i), decLon(i)); %#ok<PFCEL>

    % Send URL and read resulting depth
    depth(i) = str2double(urlread(url));
end