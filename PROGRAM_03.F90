!***********************************
!
! fortran example code 02
!
!***********************************

program main
!
!!! Fortranでは，!を記述すると，!以降は「コメントアウト」
!!! コメントアウトすると，コンパイラはその部分を無視する → メモを書き込んだり，古いバージョンのコードを残しておくことができる
!
!!! Fortranでは，コメントアウト以外で全角は使用禁止です！スペースも，改行も半角で入力すること！
!
   implicit none
   integer(4) :: IMAX !integerは整数
   integer(4), parameter :: NX = 100
   integer(8) :: F(NX), CCC(NX) !integerは整数

   call INIT !CALLはsubroutineの呼び出しを行うものです
   call CALCULATION
   call FILEOUT

contains

!***********************************
   subroutine INIT
!***********************************
      write (*, *) 'SUBROUTINE INIT START ----------'

      open (11, FILE='Input_02_Integer.txt') !入力ファイルを「11」という番号で開く

      read (11, *) IMAX !入力データ長を読み込む
      block
         integer(4) :: I
         do I = 1, IMAX
            read (11, *) F(I) !READを入力データの数だけ繰り返し行う
            write (*, *) I, F(I) !READしたデータをコマンドプロンプトに表示する（確認のため）
         end do
      end block

      write (*, *) 'SUBROUTINE INIT FINISHED ----------'
   end
!
!***********************************
   subroutine CALCULATION
!***********************************
      write (*, *) 'SUBROUTINE CALCULATION START ----------'

      !CALCULATION 2 CCCは何を求めているでしょうか？

      block
         integer(4) :: I
         integer(8) :: J
         do I = 1, IMAX
            CCC(I) = 1
            do J = 1, F(I)
               CCC(I) = CCC(I)*J
            end do
            write (*, *) I, CCC(I)
         end do
      end block

      write (*, *) 'SUBROUTINE CALCULATION FINISHED ----------'
   end
!
!***********************************
   subroutine FILEOUT
!***********************************
      open (99, FILE='dist/output_02.txt')

      block
         integer(4) :: I
         do I = 1, IMAX
            write (99, '(I5,2I20)') I, F(I), CCC(I)
         end do
      end block
   end
end program main
