export class CocktailsServiceError extends Error {
  public type: symbol | undefined;

  constructor(message?: string, type?: symbol) {
    super(message);
    this.type = type;
  }

  static ALREADY_EXISTS = Symbol('ALREADY_EXISTS');
}
