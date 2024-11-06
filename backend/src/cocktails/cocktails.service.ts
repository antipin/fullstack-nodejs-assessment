import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { type Repository } from 'typeorm';
import { Cocktails } from './cocktails.entity';

@Injectable()
export class CocktailsService {
  constructor(
    @InjectRepository(Cocktails)
    private cocktailsRepository: Repository<Cocktails>,
  ) {}

  findAll(text: string = ''): Promise<Cocktails[]> {
    const queryBuilder = this.cocktailsRepository.createQueryBuilder();
    if (text !== '') {
      // Full text PoC (slow)
      // todo: move to db-init.sql
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

  create(cocktail: Cocktails) {
    return this.cocktailsRepository.insert(cocktail);
  }

}