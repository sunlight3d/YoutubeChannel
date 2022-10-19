import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const GetUser = createParamDecorator(
  (data: unknown, context: ExecutionContext) => {
    const request:Express.Request = context.switchToHttp().getRequest();
    return request.user;
  },
);