!***********************************

! 1-DIMENSIONAL ADVECTION EQUATION
! CODED BY JIN KASHIWADA, 2022.04.07
! REVISED BY ***********, 2022.04.**
! MAIN ROUTINE

!***********************************

!
!!! Fortranでは，!を記述すると，!以降は「コメントアウト」
!!! コメントアウトすると，コンパイラはその部分を無視する → メモを書き込んだり，古いバージョンのコードを残しておくことができる
!
!!! Fortranでは，コメントアウト以外で全角は使用禁止です！スペースも，改行も半角で入力すること！
!
program advection1D_F
   implicit none
   character NUM*5
   integer(4) :: N = 1!integerは整数
   real(8) :: C = 0.20d0, DX = 0.100d0, DT = 0.050d0 !realは実数
   integer(4), parameter :: IMAX = 100
   integer(4), parameter :: NMAX = 1000
   integer(4), parameter :: NX = 100
   !! 空間側の最大数
   integer(4), parameter :: NT = 1000
   !! 時間側の最大数
   real(8) :: F(NX, NT)
   !! 拡散する量
   !!
   !! $f(x,t)$に相当する

   block
      integer(4) :: I
      do I = 1, IMAX
         F(I, N) = 0.0d0 !一旦全てゼロとする
      end do
   end block
   F(2, N) = 1.0d0
   F(3, N) = 2.0d0
   F(4, N) = 1.0d0

   call FILEOUT_SPATIAL

   do N = 1, NMAX !---計算時間ステップに関するループ------------ここから
      call CAL_ADVECTION
      if (mod(N, 20) == 0) then !mod関数は余りを算出する関数
         call FILEOUT_SPATIAL
      end if
   end do !---計算時間ステップに関するループ------------------ここまで

   stop
contains

!***********************************
   subroutine CAL_ADVECTION
!***********************************

      !ここに差分式を用いた計算を記述する
   end
!
!***********************************
   subroutine FILEOUT_SPATIAL
!***********************************

      write (NUM, '(I5.5)') N
      block
         integer(4) :: I
         open (99, FILE='OUTPUT_ADV/OUT_SPACE_'//NUM//'.TXT')
         do I = 1, IMAX
            write (99, '(2I5,F20.10)') N, I, F(I, N)
         end do
         close (99)
      end block

      block
         integer(4) :: I
         open (98, FILE='OUTPUT_ADV/OUT_SPACE_ALL.TXT') !出力ファイルを「98」という番号で開く
         do I = 1, IMAX
            write (98, '(2I5,2F10.4,F20.10)') N, I, N*DT, (I - 1)*DX, F(I, N)
         end do
         close (98)
      end block
   end
end program advection1D_F
