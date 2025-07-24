import nextJest from 'next/jest.js';

const createJestConfig = nextJest({ dir: './' });

const customJestConfig = {
  setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^.+\\.module\\.(css|sass|scss)$': 'identity-obj-proxy',
    '^.+\\.(css|sass|scss)$': 'identity-obj-proxy',
  },
  testEnvironment: 'jest-environment-jsdom',
};

export default createJestConfig(customJestConfig); 