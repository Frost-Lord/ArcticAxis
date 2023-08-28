section .text
    extern puts
    extern gets

%include "./src/os/global/functions/color.asm"
%include "./src/os/global/general/newline.asm"
%include "./src/os/global/general/gets.asm"
%include "./src/os/global/components/navigation.asm"
%include "./src/os/global/functions/clear.asm"
%include "./src/os/global/subroutine/delay.asm"