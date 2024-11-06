import { Body, Controller, HttpException, HttpStatus, Get, Post, Param, ParseIntPipe, Query, NotFoundException } from '@nestjs/common';
import { CocktailDto } from './dto/cocktail.dto';
import { CreateCocktailDto } from './dto/create-cocktail.dto';
import { CocktailsService, CocktailsServiceError } from './cocktails.service';

@Controller('cocktails')
export class CocktailsController {
  constructor(private readonly cocktailsService: CocktailsService) {}

  @Get()
  searchCocktails(@Query('q') query: string = '') : Promise<CocktailDto[]> {
    return this.cocktailsService.findAll(query);
  }

  @Post()
  async newCocktail(@Body() cocktail: CreateCocktailDto) {
    console.log("info: creating cocktail", cocktail);
    try {
      // @ts-ignore
      const res = await this.cocktailsService.create(cocktail);
      console.log("res", res);
      return true;
    } catch (error) {
      if (error instanceof CocktailsServiceError && error.type === CocktailsServiceError.ALREADY_EXISTS) {
        throw new HttpException(error.message, HttpStatus.CONFLICT);
      }
      throw error;
    }
  }

  @Get(':cocktailId')
  async findCocktail(@Param('cocktailId', ParseIntPipe) cocktailId: number): Promise<CocktailDto> {
    const cocktail = await this.cocktailsService.findOne(cocktailId);
    if (!cocktail) {
      throw new NotFoundException(`Cocktail #${cocktailId} not found`);
    }
    return cocktail;
  }
}
