function output = BehavioralStruct(block, numblocks); 
blockstarts = find(block==255);

if numel(blockstarts) == numblocks
elseif numblocks == []
    numblocks = 30;
else 
    error('ERROR: Number of 255 Presses ~= Number of Blocks');
end 
a = 0;
v = 0;
av = 0;
block = [block 255];                                        %so code can operate on last block. 
for i = 1:numel(blockstarts) - 1
    codes = block(blockstarts(i):blockstarts(i+1)-1);       %all codes in between 255 press and next 255 press (excluding 255 press)
    responses = find(codes == 1);
    stims = codes; stims(responses) = [];
    if min(stims) == 10
        a = a + 1;
        modality = 'auditory';
        output.auditory.blocks{a,1} = codes;                %all codes
        output.auditory.blocks{a,2} = i;                    %block number
        output.auditory.blocks{a,3} = numel(responses);     %number of responses
    elseif min(stims) == 30
        v = v + 1;
        modality = 'visual';
        output.visual.blocks{v,1} = codes;
        output.visual.blocks{v,2} = i;
    elseif min(stims) == 50
        av = av + 1
        modality = 'audiovisual';
        output.audiovisual.blocks{av,1} = codes;  %all codes
        output.audiovisual.blocks{av,2} = i;  %block number
    end 
end 
