"use client";
import { FC, ReactNode } from 'react';
import clsx from 'clsx';

interface ModalProps {
  open: boolean;
  onClose: () => void;
  children: ReactNode;
  title?: string;
}

const Modal: FC<ModalProps> = ({ open, onClose, children, title }) => {
  if (!open) return null;
  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black bg-opacity-50 py-8">
      <div className="w-full max-w-lg rounded-lg bg-white p-6 shadow-lg dark:bg-gray-900 max-h-[90vh] overflow-y-auto">
        {title && <h2 className="mb-4 text-xl font-semibold">{title}</h2>}
        {children}
        <button
          onClick={onClose}
          className="mt-4 rounded-md bg-red-500 px-4 py-2 text-white hover:bg-red-600"
        >
          Close
        </button>
      </div>
    </div>
  );
};

export default Modal; 