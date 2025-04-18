!***********************************
!
! fortran example code 01
!
!***********************************

program main
   IMPLICIT none

!
!!! Fortranでは，!を記述すると，!以降は「コメントアウト」
!!! コメントアウトすると，コンパイラはその部分を無視する → メモを書き込んだり，古いバージョンのコードを残しておくことができる
!
!!! Fortranでは，コメントアウト以外で全角は使用禁止です！スペースも，改行も半角で入力すること！
!
   INTEGER(4), parameter :: NX = 100
   integer(4) :: I, IMAX, IOS !integerは整数
   real(8) :: AAA, BBB !realは実数
   real(8) :: F(NX) !realは実数

   CALL INIT !CALLはsubroutineの呼び出しを行うものです
   CALL CALCULATION
   CALL FILEOUT

   WRITE (*, *) 'enter to finish'
   READ (*, *)

contains
!***********************************
   SUBROUTINE INIT
!***********************************

      WRITE (*, *) 'SUBROUTINE INIT START ----------'

      OPEN (11, FILE='Input_01_Float.txt', STATUS='OLD', ACTION='READ', IOSTAT=IOS)
      IF (IOS /= 0) THEN
         WRITE (*, *) 'Error: Unable to open file Input_01_Float.txt'
         STOP
      END IF

      READ (11, *, IOSTAT=IOS) IMAX
      IF (IOS /= 0) THEN
         WRITE (*, *) 'Error: Failed to read IMAX from file'
         STOP
      END IF

      DO I = 1, IMAX
         READ (11, *, IOSTAT=IOS) F(I)
         IF (IOS /= 0) THEN
            WRITE (*, *) 'Error: Not enough data in file for F(', I, ')'
            STOP
         END IF
         WRITE (*, *) I, F(I)
      END DO

      WRITE (*, *) 'SUBROUTINE INIT FINISHED ----------'

      CLOSE (11)
      RETURN
   END SUBROUTINE INIT
!
!***********************************
   SUBROUTINE CALCULATION
!***********************************

      WRITE (*, *) 'SUBROUTINE CALCULATION START ----------'

      !CALCULATION 1 AAAとBBBはそれぞれ何を求めているでしょうか？

      DO I = 1, IMAX
         AAA = AAA + F(I)
         WRITE (*, *) I, F(I), AAA
      END DO
      BBB = AAA/IMAX
      WRITE (*, *) BBB

      WRITE (*, *) 'SUBROUTINE CALCULATION FINISHED ----------'

      RETURN
   END SUBROUTINE CALCULATION
!
!***********************************
   SUBROUTINE FILEOUT
!***********************************

      OPEN (99, FILE='dist/output_02.txt')

      WRITE (99, '(F20.10)') AAA
      WRITE (99, '(F20.10)') BBB

      RETURN
   END SUBROUTINE FILEOUT

end program main
