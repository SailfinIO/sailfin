// jest.config.ts
import type { Config } from 'jest';

const config: Config = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  rootDir: './',

  // Update testMatch to include tests alongside source files
  testMatch: ['<rootDir>/src/**/*.test.ts'],

  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov'],

  moduleFileExtensions: ['ts', 'js', 'json'],

  transform: {
    '^.+\\.(ts|tsx)$': [
      'ts-jest',
      {
        tsconfig: 'tsconfig.test.json',
      },
    ],
  },

  coveragePathIgnorePatterns: ['node_modules/', '/__mocks__/'],

  // Update moduleDirectories to include 'src' instead of 'lib'
  moduleDirectories: ['node_modules', 'src'],
};

export default config;
