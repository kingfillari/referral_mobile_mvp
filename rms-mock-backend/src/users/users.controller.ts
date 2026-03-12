import { Body, Controller, Post, HttpException, HttpStatus } from '@nestjs/common';
import { UsersService, User } from './users.service';

@Controller('auth')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post('register')
  register(@Body() body: { fullName: string; email: string; password: string; role: string }) {
    try {
      const { fullName, email, password, role } = body;

      if (!fullName || !email || !password || !role) {
        throw new HttpException('Missing fields', HttpStatus.BAD_REQUEST);
      }

      if (!['ADMIN', 'DOCTOR', 'NURSE', 'HOSPITAL'].includes(role.toUpperCase())) {
        throw new HttpException('Invalid role', HttpStatus.BAD_REQUEST);
      }

      const user = this.usersService.create({
        fullName,
        email,
        password,
        role: role.toUpperCase() as User['role'],
      });

      return {
        user,
        token: `fake-jwt-token-${user.id}`,
      };
    } catch (err: any) {
      throw new HttpException(err.message, HttpStatus.BAD_REQUEST);
    }
  }

  @Post('login')
  login(@Body() body: { email: string; password: string }) {
    const user = this.usersService.findByEmail(body.email);
    if (!user || user.password !== body.password) {
      throw new HttpException('Invalid email or password', HttpStatus.UNAUTHORIZED);
    }

    return {
      user,
      token: `fake-jwt-token-${user.id}`,
    };
  }
}