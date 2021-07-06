program test_model_sarima
    use stdlib_error, only: error_stop
    use forlab_io, only: file, disp
    use fortsa_model, only: sarima_init, sarima_setMethod, sarima_predict, &
        sarima_exec, sarima_summary, sarima_free
    use, intrinsic :: iso_c_binding
    implicit none 
    integer :: i, N, d, L
    real(8), target, allocatable :: inp(:)
    integer :: p, q
    integer :: s, p_, d_, q_
    real(8), target, allocatable :: phi(:), theta(:)
    real(8), target, allocatable :: phi_(:), theta_(:)
    real(8), target, allocatable :: xpred(:), amse(:)
    type(c_ptr) :: obj = c_null_ptr
    target :: obj
    type(file) :: infile

    p = 0
    d = 1
    q = 1
    s = 12
    p_ = 0
    d_ = 1
    q_ = 1

    L = 5

    allocate(phi(p), theta(q), phi_(p_), theta_(q_))
    allocate(xpred(L), amse(L))

    infile = file('example/data/seriesG.txt', 'r')
    if(.not.infile%exist()) call error_stop('Error: file not exist, '//infile%filename)
    call infile%open()
    call infile%countlines()
    N = infile%lines
    allocate(inp(N))

    do i = 1, N
        read(infile%unit, *) inp(i)
        inp(i) = log(inp(i))
    end do
    call infile%close()
    
    obj = sarima_init(p, d, q, s, p_, d_, q_, N)
    call sarima_setMethod(obj, 0)   !! Method 0 ("MLE") is default so this step is unnecessary. The method also accepts values 1 ("CSS") and 2 ("Box-Jenkins")
        !! sarima_setOptMethod(obj, 7);// Method 7 ("BFGS with More Thuente Line Search") is default so this step is unnecessary. The method also accepts values 0,1,2,3,4,5,6. Check the documentation for details.
    call sarima_exec(obj, c_loc(inp(1)))
    call sarima_summary(obj)
        !! Predict the next 5 values using the obtained ARIMA model
    call sarima_predict(obj, c_loc(inp(1)), L, c_loc(xpred(1)), c_loc(amse(1)))
    call disp(xpred, 'Predicted Values : ')

    call disp(sqrt(amse), 'Standard Errors : ')

    call sarima_free(obj)
    deallocate(inp, phi, theta, phi_, theta_, xpred, amse)

end program test_model_sarima