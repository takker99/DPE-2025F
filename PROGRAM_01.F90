!***********************************
!
! fortran example code 00
!
!***********************************

!
!!! Fortranでは，!を記述すると，!以降は「コメントアウト」
!!! コメントアウトすると，コンパイラはその部分を無視する → メモを書き込んだり，古いバージョンのコードを残しておくことができる
!
!!! Fortranでは，コメントアウト以外で全角は使用禁止です！スペースも，改行も半角で入力すること！
!
program main
   IMPLICIT none
   real(8) :: A, B !realは実数

   WRITE (*, *) 'Aの値を入力してください'
   READ (*, *) A
   WRITE (*, *) 'Bの値を入力してください'
   READ (*, *) B

   WRITE (*, *) 'A+B=', A + B
   WRITE (*, *) 'A-B=', A - B
   WRITE (*, *) 'A*B=', A*B
   WRITE (*, *) 'A/B=', A/B

   WRITE (*, *) 'enter to finish'
   READ (*, *)
   STOP
END program main
