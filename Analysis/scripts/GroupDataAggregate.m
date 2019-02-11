basePath = 'C:\Users\achen52\Documents\GitHub\movingstims\';                    %Point to movingstims

%10108009
path = [basePath 'IEInitial\logs\'];
filename = '10108009-IEInitial.log';
[struct, cond] = importPresentationLog(strcat(path,filename));

