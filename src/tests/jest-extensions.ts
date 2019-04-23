import "jest";

declare global {
  export namespace jest {
    interface Expect {
      toBeTypeOrNull(classType: any): any;

      toBeDivisibleBy(classType: any): any;
    }
  }
}

expect.extend({
  toBeTypeOrNull(received, argument) {
    try {
      expect(received).toEqual(expect.any(argument));
    } catch (e) {
      if (received !== null) {
        return {
          message: () => `expected ${received} to be ${argument} type or null`,
          pass: false
        };
      }
    }

    return {
      message: () => `Ok`,
      pass: true
    };
  }
});

