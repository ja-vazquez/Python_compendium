subroutine sum_sq(x,n,s)
  implicit none
  integer, intent(in) :: n
  integer, dimension(n), intent(in) :: x
  integer, intent(out) :: s
  ! 
  s = sum(x*x)
  ! 
end subroutine sum_sq

  
