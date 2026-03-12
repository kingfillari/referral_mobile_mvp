import { Injectable } from '@nestjs/common';

export type User = {
  id: number;
  fullName: string;
  email: string;
  password: string; // in real app, hash this
  role: 'ADMIN' | 'DOCTOR' | 'NURSE' | 'HOSPITAL';
};

@Injectable()
export class UsersService {
  private users: User[] = []; // in-memory store

  create(user: Omit<User, 'id'>): User {
    const exists = this.users.find(u => u.email === user.email);
    if (exists) throw new Error('Email already exists');

    const newUser: User = { ...user, id: this.users.length + 1 };
    this.users.push(newUser);
    return newUser;
  }

  findByEmail(email: string): User | undefined {
    return this.users.find(u => u.email === email);
  }
}