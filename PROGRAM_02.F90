!***********************************
!
! fortran example code 01
!
!***********************************

program main
   implicit none

!
!!! Fortranでは，!を記述すると，!以降は「コメントアウト」
!!! コメントアウトすると，コンパイラはその部分を無視する → メモを書き込んだり，古いバージョンのコードを残しておくことができる
!
!!! Fortranでは，コメントアウト以外で全角は使用禁止です！スペースも，改行も半角で入力すること！
!
   integer(4), parameter :: NX = 100
   integer(4) :: I, IMAX, IOS !integerは整数
   real(8) :: AAA, BBB !realは実数
   real(8) :: F(NX) !realは実数

   call INIT !CALLはsubroutineの呼び出しを行うものです
   call CALCULATION
   call FILEOUT

   write (*, *) 'enter to finish'
   read (*, *)

contains
!***********************************
   subroutine INIT
!***********************************

      write (*, *) 'SUBROUTINE INIT START ----------'

      open (11, FILE='Input_01_Float.txt', STATUS='OLD', ACTION='READ', IOSTAT=IOS)
      if (IOS .ne. 0) then
         write (*, *) 'Error: Unable to open file Input_01_Float.txt'
         stop
      end if

      read (11, *, IOSTAT=IOS) IMAX
      if (IOS .ne. 0) then
         write (*, *) 'Error: Failed to read IMAX from file'
         stop
      end if

      do I = 1, IMAX
         read (11, *, IOSTAT=IOS) F(I)
         if (IOS .ne. 0) then
            write (*, *) 'Error: Not enough data in file for F(', I, ')'
            stop
         end if
         write (*, *) I, F(I)
      end do

      write (*, *) 'SUBROUTINE INIT FINISHED ----------'

      close (11)
      return
   end subroutine INIT
!
!***********************************
   subroutine CALCULATION
!***********************************

      write (*, *) 'SUBROUTINE CALCULATION START ----------'

      !CALCULATION 1 AAAとBBBはそれぞれ何を求めているでしょうか？

      do I = 1, IMAX
         AAA = AAA + F(I)
         write (*, *) I, F(I), AAA
      end do
      BBB = AAA/IMAX
      write (*, *) BBB

      write (*, *) 'SUBROUTINE CALCULATION FINISHED ----------'

      return
   end subroutine CALCULATION
!
!***********************************
   subroutine FILEOUT
!***********************************

      open (99, FILE='dist/output_02.txt')

      write (99, '(F20.10)') AAA
      write (99, '(F20.10)') BBB

      return
   end subroutine FILEOUT

end program main
