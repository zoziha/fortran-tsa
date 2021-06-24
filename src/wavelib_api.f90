module wavelib_api
    implicit none
    private

    public :: wave_init, wt_init, &
                wave_summary, wt_summary, &
                modwt, imodwt, &
                wave_free, wt_free

    interface
        function wave_init(wname) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value, intent(in) :: wname
            type(c_ptr) :: wave_init
                !! pointer point to `wave_object`
        end function wave_init

        function wt_init(wave, method, siglength, J) bind(c)
            use, intrinsic :: iso_c_binding, only: c_int, c_ptr
            type(c_ptr), value :: wave
                !! pointer point to `wave_object`
            type(c_ptr), value, intent(in) :: method
                !! const char*
            type(c_int), value :: siglength, J 
            type(c_ptr) :: wt_init
                !! wt_object
        end function wt_init

        subroutine wave_summary(obj) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value :: obj
                !! `wave_object`
        end subroutine wave_summary

        subroutine wt_summary(wt) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value :: wt
                !! wt_object
        end subroutine wt_summary

        subroutine modwt(wt, inp) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value :: wt
                !! wt_object
            type(c_ptr), value, intent(in) :: inp
                !! const double*
        end subroutine modwt

        subroutine imodwt(wt, dwtop) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value :: wt
                !! wt_object
            type(c_ptr), value :: dwtop
                !! double*
        end subroutine imodwt

        subroutine wave_free(object) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value :: object
                !! wave_object
        end subroutine wave_free

        subroutine wt_free(object) bind(c)
            use, intrinsic :: iso_c_binding, only: c_ptr
            type(c_ptr), value :: object
                !! wt_object
        end subroutine wt_free

    endinterface

contains
    

end module wavelib_api