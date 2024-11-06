import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { type Repository, QueryFailedError } from 'typeorm';
import { Cocktails } from './cocktails.entity';
import { CocktailsServiceError } from './cocktails.service.error';

@Injectable()
export class CocktailsService {
  constructor(
    @InjectRepository(Cocktails)
    private cocktailsRepository: Repository<Cocktails>,
  ) {}

  findAll(text: string = ''): Promise<Cocktails[]> {
    const queryBuilder = this.cocktailsRepository.createQueryBuilder();
    if (text !== '') {
      queryBuilder.where(
        `to_tsvector('english', title || ' ' || description) @@ to_tsquery(:query)`,
        { query: text }
      )
    }
    return queryBuilder.getMany();
  }

  findOne(id: number): Promise<Cocktails | null> {
    return this.cocktailsRepository.findOneBy({ id });
  }

  async create(cocktail: Cocktails) {
    try {
      return await this.cocktailsRepository.insert(cocktail);
    } catch (error) {
      if (error instanceof QueryFailedError && error.message.includes('duplicate key')) {
        throw new CocktailsServiceError(`Cocktail "${cocktail.title}" already exists`, CocktailsServiceError.ALREADY_EXISTS);
      }
      throw error;
    }
  }
}

export { CocktailsServiceError};