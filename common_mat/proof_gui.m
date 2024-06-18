function file_name=proof_gui(thePrompt,file_name,theOutputFile)
%function file_name=proof_gui(file_name)
% PROOF_GUI Carga de archivos basado en GUI
% Esta funcion, basada en la rutina ncdump, permite
% ingresar archivos seleccionandolos fisicamente
% en lugar de escribir su path como variable de entrada.
%
% La Variable de Salida es:
%
% file_name = path del archivo ingresado (char array)

if nargin < 2, help proof_gui, file_name = '*.*'; end
if nargin < 3, theOutputFile = 'stdout'; end   % stdout.

if isa(file_name, 'ncitem')
    file_name = name(parent(parent(file_name)));
end

if any(file_name == '*')
   theFilterSpec = file_name;
   [theFile, thePath] = uigetfile(theFilterSpec, thePrompt);
   if ~any(theFile), return, end
   file_name = [thePath theFile];
end

if any(theOutputFile == '*')
   theFilterSpec = theOutputFile;
   thePrompt = 'Select a Text Output File:';
   [theFile, thePath] = uiputfile(theFilterSpec, thePrompt);
   if ~any(theFile), return, end
   theOutputFile = [thePath theFile];
end