import { NestFactory } from '@nestjs/core';
import { globalValidationPipe } from './validation.pipe';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule, { cors: true });
  app.useGlobalPipes(globalValidationPipe);
  await app.listen(3000);
  console.log("Backend listening on port 3000")
}
bootstrap();
