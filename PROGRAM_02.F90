module md_fort

   INTEGER(4), parameter :: NX = 100
   integer(4) :: I, IMAX !integerは整数
   real(8) :: AAA, BBB !realは実数
   real(8) :: F(NX) !realは実数

end module md_fort

!***********************************
!
! fortran example code 01
!
!***********************************

!
!!! Fortranでは，!を記述すると，!以降は「コメントアウト」
!!! コメントアウトすると，コンパイラはその部分を無視する → メモを書き込んだり，古いバージョンのコードを残しておくことができる
!
!!! Fortranでは，コメントアウト以外で全角は使用禁止です！スペースも，改行も半角で入力すること！
!
USE md_fort
IMPLICIT none

CALL INIT !CALLはsubroutineの呼び出しを行うものです
CALL CALCULATION
CALL FILEOUT

WRITE (*, *) 'enter to finish'
READ (*, *)

STOP
END

!***********************************
SUBROUTINE INIT
!***********************************
   USE md_fort
   IMPLICIT NONE

   WRITE (*, *) 'SUBROUTINE INIT START ----------'

   OPEN (11, FILE='INPUT_01_FLOAT.TXT') !入力ファイルを「11」という番号で開く

   READ (11, *) IMAX !入力データ長を読み込む
   DO I = 1, IMAX
      READ (11, *) F(I) !READを入力データの数だけ繰り返し行う
      WRITE (*, *) I, F(I) !READしたデータをコマンドプロンプトに表示する（確認のため）
   END DO

   WRITE (*, *) 'SUBROUTINE INIT FINISHED ----------'

   RETURN
END
!
!***********************************
SUBROUTINE CALCULATION
!***********************************
   USE md_fort
   IMPLICIT NONE

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
END
!
!***********************************
SUBROUTINE FILEOUT
!***********************************
   USE md_fort
   IMPLICIT NONE

   OPEN (99, FILE='OUTPUT_02.TXT')

   WRITE (99, '(F20.10)') AAA
   WRITE (99, '(F20.10)') BBB

   RETURN
END
