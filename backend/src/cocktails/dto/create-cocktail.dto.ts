import { OmitType } from '@nestjs/swagger';
import { CocktailDto } from './cocktail.dto';

export class CreateCocktailDto extends OmitType(CocktailDto, ['id']) {};
