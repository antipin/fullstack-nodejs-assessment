import { Body, Controller, Get, Post, Param, ParseIntPipe, Query, NotFoundException } from '@nestjs/common';
import { Cocktails } from './cocktails.entity';
import { CocktailsService } from './cocktails.service';

@Controller('cocktails')
export class CocktailsController {
  constructor(private readonly cocktailsService: CocktailsService) {}

  @Get()
  searchCocktails(@Query('q') query: string = '') : Promise<Cocktails[]> {
    return this.cocktailsService.findAll(query);
  }

  @Post()
  async newCocktail(@Body() cocktail: Cocktails) {
    console.log("info: creating cocktail", cocktail);
    const res = await this.cocktailsService.create(cocktail);
    console.log("res", res);
    return true;
  }

  @Get(':cocktailId')
  async findCocktail(@Param('cocktailId', ParseIntPipe) cocktailId: number): Promise<Cocktails> {
    const cocktail = await this.cocktailsService.findOne(cocktailId);
    if (!cocktail) {
      throw new NotFoundException(`Cocktail #${cocktailId} not found`);
    }
    return cocktail;
  }
}
