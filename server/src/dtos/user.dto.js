export const signinResponseDTO = (user) => {
  return {
    email: user.email,
    name: user.user_name,
  };
};
