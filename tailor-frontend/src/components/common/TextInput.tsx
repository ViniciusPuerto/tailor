import { FC, InputHTMLAttributes } from 'react';
import clsx from 'clsx';

interface TextInputProps extends InputHTMLAttributes<HTMLInputElement> {}

const TextInput: FC<TextInputProps> = ({ className, ...rest }) => {
  const base = 'block w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm placeholder-gray-400 focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm bg-white text-gray-900 dark:bg-gray-800 dark:text-gray-100';
  return <input className={clsx(base, className)} {...rest} />;
};

export default TextInput; 