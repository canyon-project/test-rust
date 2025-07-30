use std::os::raw::c_int;

/// 添加两个整数
/// 
/// # Safety
/// 这个函数是安全的，因为它只处理基本的整数类型
#[no_mangle]
pub extern "C" fn add(a: c_int, b: c_int) -> c_int {
    a + b
}

/// 添加两个浮点数
/// 
/// # Safety
/// 这个函数是安全的，因为它只处理基本的浮点类型
#[no_mangle]
pub extern "C" fn add_float(a: f64, b: f64) -> f64 {
    a + b
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_add() {
        assert_eq!(add(2, 3), 5);
        assert_eq!(add(-1, 1), 0);
    }

    #[test]
    fn test_add_float() {
        assert_eq!(add_float(2.5, 3.5), 6.0);
    }
}