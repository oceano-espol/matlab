function compass=deg2compass(deg)
% function compass=deg2compass(deg)
%
% PRUEBA!!!

def_deg=[348.75	360
    0       11.25
    11.25	33.75
    33.75	56.25
    56.25	78.75
    78.75	101.25
    101.25	123.75
    123.75	146.25
    146.25	168.75
    168.75	191.25
    191.25	213.75
    213.75	236.25
    236.25	258.75
    258.75	281.25
    281.25	303.75
    303.75	326.25
    326.25	348.75];

def_txt={'N'
    'N'
    'NEN'
    'NE'
    'ENE'
    'E'
    'ESE'
    'SE'
    'SES'
    'S'
    'SWS'
    'SW'
    'WSW'
    'W'
    'WNW'
    'NW'
    'NWN'};

[isz,jsz]=size(deg); deg=deg(:);

for i=1:length(deg);
    i_deg=find(def_deg(:,1)<=deg(i) & def_deg(:,2)>deg(i));
    if length(i_deg)==1,
        compass{i}=def_txt{i_deg};
    else
        error('revisar!')
    end
end

compass=reshape(compass,isz,jsz);
