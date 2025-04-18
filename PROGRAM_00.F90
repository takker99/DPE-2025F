!***********************************
!
! fortran example code 00
!
!***********************************
!

! 必ずprogramでくくる必要がある
program ExampleProgram
   implicit none

   write (*, *) 'コンパイルと実行に成功しました！！！'
   write (*, *) 'Press Enter to continue...'
   read (*, *)

   stop
end program ExampleProgram
