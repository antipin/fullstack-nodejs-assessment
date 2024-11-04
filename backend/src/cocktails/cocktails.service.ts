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

  findAll(): Promise<Cocktails[]> {
    return this.cocktailsRepository.find();
  }

  findOne(id: number): Promise<Cocktails | null> {
    return this.cocktailsRepository.findOneBy({ id });
  }

  create(cocktail: Cocktails) {
    return this.cocktailsRepository.insert(cocktail);
  }

}