import { Body, Controller, HttpException, HttpStatus, Get, Post, Param, ParseIntPipe, Query, NotFoundException } from '@nestjs/common';
import { ApiOperation, ApiResponse, ApiQuery, ApiParam, ApiTags } from '@nestjs/swagger';
import { CocktailDto } from './dto/cocktail.dto';
import { CreateCocktailDto } from './dto/create-cocktail.dto';
import { CocktailsService, CocktailsServiceError } from './cocktails.service';

@Controller('cocktails')
export class CocktailsController {
  constructor(private readonly cocktailsService: CocktailsService) {}

  @Get()
  @ApiOperation({ summary: 'Searches for cocktails' })
  @ApiTags('Cocktails')
  @ApiQuery({
    name: 'q',
    required: false,
    description: 'Query string for searching cocktails',
    example: 'Virgin'
  })
  @ApiResponse({
    status: 200,
    description: 'A list of cocktails matching the search query',
    type: [CocktailDto],
  })
  searchCocktails(@Query('q') query: string = '') : Promise<CocktailDto[]> {
    return this.cocktailsService.findAll(query);
  }

  @Post()
  @ApiOperation({ summary: 'Creates a new cocktail' })
  @ApiTags('Cocktails')
  @ApiResponse({
    status: 201,
    description: 'The record has been successfully created.',
  })
  @ApiResponse({
    status: 400,
    description: 'Bad request. Validation errors.',
  })
  @ApiResponse({
    status: 409,
    description: 'Conflict. The record already exists.',
  })
  async newCocktail(@Body() cocktail: CreateCocktailDto) {
    console.log("info: creating cocktail", cocktail);
    try {
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
  @ApiOperation({ summary: 'Returns a cocktail by ID' })
  @ApiTags('Cocktails')
  @ApiParam({
    name: 'cocktailId',
    type: Number,
    description: 'The ID of the cocktail to retrieve',
  })
  @ApiResponse({
    status: 200,
    description: 'The found cocktail',
    type: CocktailDto,
  })
  @ApiResponse({
    status: 404,
    description: 'Cocktail not found',
  })
  async findCocktail(@Param('cocktailId', ParseIntPipe) cocktailId: number): Promise<CocktailDto> {
    const cocktail = await this.cocktailsService.findOne(cocktailId);
    if (!cocktail) {
      throw new NotFoundException(`Cocktail #${cocktailId} not found`);
    }
    return cocktail;
  }
}
