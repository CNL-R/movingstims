function output = IdentifyBlocks(block)
block = [block 255];    
blockstarts = find(block==255);
output = [];
a = 0;
v = 0;
av = 0;
                                    %so code can operate on last block. 
for i = 1:numel(blockstarts) - 1
    codes = block(blockstarts(i):blockstarts(i+1)-1);       %all codes in between 255 press and next 255 press (excluding 255 press)
    responses = find(codes == 1);
    stims = codes; stims(responses) = [];
    if min(stims) == 10
        a = a + 1;
        output = [output 1];
        
    elseif min(stims) == 30
        v = v + 1;
        output = [output 2];

    elseif min(stims) == 50
        av = av + 1;
        output = [output 3];
    end 
end 
