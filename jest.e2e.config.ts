// jest.e2e.config.ts
import type { Config } from 'jest';

const config: Config = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  rootDir: './',

  // Adjust testMatch if E2E tests have moved
  testMatch: ['<rootDir>/e2e/**/*.e2e.test.ts'],

  collectCoverage: false,

  transform: {
    '^.+\\.(ts|tsx)$': [
      'ts-jest',
      {
        tsconfig: 'tsconfig.json',
      },
    ],
  },
};

export default config;
