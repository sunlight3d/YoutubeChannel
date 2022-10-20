import { Injectable } from '@nestjs/common'
import { PrismaService } from '../prisma/prisma.service'
import { UpdateUserDTO } from './dto'
@Injectable()
export class UserService {
    constructor(private prismaService: PrismaService) {}
    async updateUser(userId: number, updateUserDTO: UpdateUserDTO) {
        const user = await this.prismaService.user.update({
            where: {
                id: userId,
            },
            data: {...updateUserDTO}
            //{...updateUserDTO} is a Cloned object of updateUserDTO
        })
        delete user.hashedPassword
    }
}
