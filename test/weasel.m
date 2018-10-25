%Me thinks it is like a weasel

charArray=char([32 65:1:90]); %65=A; 90=Z; 32=space

%All reference strings are case sensitive; supply only CAPITAL letters
refString='METHINKS IT IS LIKE A WEASEL'; %Line from Hamlet
%refString='ABLE WAS I ERE I SAW ELBA '; %Napoleon
%refString='SUPERCALLIFRAGILISTIC EXPIALIDOCIUS'; %Line from Mary Poppins
%refString='SURELY YOU ARE JOKING MR FEYNMAN'; %Feynman book
%refString='WHAT DO YOU CARE WHAT OTHER PEOPLE THINK'; %Feynman book

M=length(refString);

%rand('state', 1234);

N=100*10*10; %number of iterations
L=100; %100 copies
Q=50; %20; %5% chance=1/20
P=M*L/Q; 

    %starting string of random M characters
    charIndex=round(rand(1,M)*27);
    for count=1:M,
       if charIndex(count)==0, charIndex(count)=1;end
    end  
    string0=charArray(charIndex);string1=[];
        
for iteration=1:N,
    
        %copy string 100 times per generation
        for count=1:L, %28*100=2800
          string1=[string1 string0];    
        end

        
        %random mutation with 5% chance for every character
        for count=1:P,
            index2=round(rand(1)*Q);if index2==0, index2=1;end
            charIndex1=round(rand(1)*27); if charIndex1==0, charIndex1=1;end
            string1((count-1)*Q+index2)=charArray(charIndex1);
        end
        
        %compare min distance with desired target reference string
        score=zeros(1,L);
        for count=1:L,
           for count1=1:M,
             if string1((count-1)*M+count1)==refString(count1),
               score(count)=score(count)+1;    
             end
           end
        end
        
        [maxVal maxIndex]=max(score);
        
        if maxVal==M,
          stopFlag=1; 
          string1((maxIndex-1)*M+(1:M))
          iteration
          break   
        else
            
        survivorString=string1((maxIndex-1)*M+(1:M)); %else choose survivor string with max score
        
        str_1=sprintf('%d', iteration);
        str_2='    ';
        newString=strcat(str_1,str_2, survivorString);
        %disp(newString)
        disp(str_1)
        disp(survivorString)
        
        clear string1;   
        string0=survivorString;string1=[];
        end

     pause(0.2)   
        
end