import { type INestApplication } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { type AppModule } from './app.module';

export async function bootstrapDocs(app: INestApplication<AppModule>) {
    const config = new DocumentBuilder()
        .setTitle('Cocktails')
        .setDescription('The cocktails API description')
        .setVersion('1.0')
        .build();
    const documentFactory = () => SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('docs', app, documentFactory);
}
