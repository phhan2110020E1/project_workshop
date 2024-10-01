import { getSession } from 'next-auth/react';
import prisma from '../../lib/prisma'; // Import Prisma (hoặc thư viện ORM bạn đang sử dụng)

export default async (req, res) => {
  const session = await getSession({ req });

  if (!session) {
    return res.status(401).json({ error: 'Bạn chưa đăng nhập' });
  }

  if (req.method !== 'PUT') {
    return res.status(405).json({ error: 'Phương thức không được hỗ trợ' });
  }

  try {
    const { name, email, phone, image, id } = req.body;

    // Thực hiện việc cập nhật thông tin người dùng trong cơ sở dữ liệu
    const updatedUser = await prisma.user.update({
      where: { id: session.user.id }, // Sử dụng ID của người dùng từ phiên để xác định người dùng cần cập nhật
      data: {
        name: name,
        email: email,
        phone: phone,
        image: image,
      },
    });

    // Sau khi cập nhật thông tin thành công, bạn có thể gửi phản hồi với mã thành công và dữ liệu người dùng cập nhật
    res.status(200).json({ message: 'Cập nhật thông tin người dùng thành công', user: updatedUser });
  } catch (error) {
    // Trường hợp xảy ra lỗi server
    res.status(500).json({ error: 'Lỗi server' });
  }
};
