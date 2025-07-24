import { ButtonHTMLAttributes, FC } from 'react';
import clsx from 'clsx';

interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: 'primary' | 'secondary';
}

const Button: FC<ButtonProps> = ({ variant = 'primary', className, children, ...rest }) => {
  const base = 'rounded-md px-4 py-2 font-medium focus:outline-none focus:ring-2 focus:ring-offset-2';
  const variants = {
    primary: 'bg-indigo-600 text-white hover:bg-indigo-700 focus:ring-indigo-500',
    secondary: 'bg-gray-100 text-gray-900 hover:bg-gray-200 focus:ring-gray-400',
  };

  return (
    <button className={clsx(base, variants[variant], className)} {...rest}>
      {children}
    </button>
  );
};

export default Button; 