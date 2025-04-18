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
   implicit none
   real(8) :: A, B !realは実数

   write (*, *) 'Aの値を入力してください'
   read (*, *) A
   write (*, *) 'Bの値を入力してください'
   read (*, *) B

   write (*, *) 'A+B=', A + B
   write (*, *) 'A-B=', A - B
   write (*, *) 'A*B=', A*B
   write (*, *) 'A/B=', A/B

   write (*, *) 'enter to finish'
   read (*, *)
   stop
end program main
