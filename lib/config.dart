// const url = 'http://localhost:5000/api';
// const url = 'http://10.0.2.2:5000/api/';
// const url = 'http://10.0.0.2:5000/api/';
const url = 'http://3.82.117.91/api/';
// const url = 'https://ap-landscaping-backend.onrender.com/api/';

// login / signup
const providerRegister = "${url}provider/signup";
const customerRegister = "${url}customer/signup";
const providerLogin = "${url}provider/login";
const customerLogin = "${url}customer/login";
const superUserRegister = "${url}superuser/signup";
const superUserLogin = "${url}super-user/login";
const superUserLogout = "${url}super-user/logout";

// superuser
const superUserGetAllUsers = "${url}super-user/customers";
const superUserGetAllProviders = "${url}super-user/providers";
const superUserGetOrdersWithNoProviders = "${url}super-user/unassigned";
const superUserAssignProvider = "${url}orders/assign-provider";

// customer
const customerOrders = "${url}orders/customerOrders/";
const customerPastOrders = "${url}orders/past/customer";
const customerUpcomingOrders = "${url}orders/upcoming/customer";
const customerProfileInfo = "${url}customer/profile";
const customerLogout = "${url}customer/logout";
const customerForgotPasswordByEmail = "${url}forgot-password/email";
const customerForgotPasswordByPhone = "${url}forgot-password/phone";
const customerResetPassword = "${url}forgot-password/reset-password";

// provider
const providerOrders = "${url}orders/providerOrders/";
const providerPastOrders = "${url}orders/past/provider";
const providerUpcomingOrders = "${url}orders/upcoming/provider";
const providerProfileInfo = "${url}provider/profile";
const providerLogout = "${url}provider/logout";
const providerForgotPasswordByEmail = "${url}forgot-password/email";
const providerForgotPasswordByPhone = "${url}forgot-password/phone";
const providerResetPassword = "${url}forgot-password/reset-password";
const acceptOrderByProvider = "${url}orders/accept";

// crew
const crewCreate = "${url}crews/create";
const crewListByProvider = "${url}crews/getAllByProvider";
const crewDelete = "${url}crews/delete/";
const crewUpdate = "${url}crews/update/";
const crewAssignOrder = "${url}crews/assignOrder/";

// orders
const cancelOrderByCustomer = "${url}orders/cancel/customer/";
const cancelOrderByProvider = "${url}orders/cancel/provider/";
const updateOrder = "${url}orders/update/:orderId";
const createOrder = "${url}orders/create";
const getOrder = "${url}orders/";
const providerDetailsbyId = "${url}provider/profile/";
const rescheduleByCustomer = "${url}orders/update/customer/";
const customerDetailsbyId = "${url}customer/profile/";
const rescheduleByProvider = "${url}orders/update/provider/";

// google login
const googleLogin = "${url}user/auth/google";

// payment
const paymentEngage = "${url}payment/checkout/session";