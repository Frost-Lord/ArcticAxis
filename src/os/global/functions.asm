section .text
    extern puts

%include "./src/os/global/functions/color.asm"
%include "./src/os/global/general/newline.asm"
%include "./src/os/global/components/navigation.asm"
%include "./src/os/global/functions/clear.asm"
%include "./src/os/global/subroutine/delay.asm"