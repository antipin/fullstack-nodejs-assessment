import { ValidationPipe, ValidationError, BadRequestException } from '@nestjs/common';

/**
 * Groups error messages by field
 */
export const globalValidationPipe = new ValidationPipe({
  exceptionFactory: (validationErrors: ValidationError[] = []) => {
    return new BadRequestException(
      validationErrors.map((error) => ({
        field: error.property,
        errors: Object.values(error.constraints),
      })),
    );
  },
});