module md_fort

   INTEGER(4), parameter :: NX = 100
   integer(4) :: I, IMAX, J !integerは整数
   INTEGER(8) :: F(NX), CCC(NX) !integerは整数

end module md_fort

!***********************************
!
! fortran example code 02
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

STOP
END

!***********************************
SUBROUTINE INIT
!***********************************
   USE md_fort
   IMPLICIT NONE

   WRITE (*, *) 'SUBROUTINE INIT START ----------'

   OPEN (11, FILE='INPUT_02_INTEGER.TXT') !入力ファイルを「11」という番号で開く

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

   !CALCULATION 2 CCCは何を求めているでしょうか？

   DO I = 1, IMAX
      CCC(I) = 1
      DO J = 1, F(I)
         CCC(I) = CCC(I)*J
      END DO
      WRITE (*, *) I, CCC(I)
   END DO

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

   DO I = 1, IMAX
      WRITE (99, '(I5,2I20)') I, F(I), CCC(I)
   END DO

   RETURN
END
