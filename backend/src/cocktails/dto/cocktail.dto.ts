import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, MaxLength, IsNumber, Min, Max } from 'class-validator';

export class CocktailDto {
  
  id: number;

  @IsNotEmpty()
  @MaxLength(100)
  @ApiProperty({
    description: "Cocktail title"
  })
  title: string;

  @IsNotEmpty()
  @MaxLength(1024)
  @ApiProperty({
    description: "Cocktail description"
  })
  description: string;

  @IsNotEmpty()
  @IsNumber()
  @Min(0)
  @Max(999)
  @ApiProperty({
    description: "Cocktail price"
  })
  price: number;
}