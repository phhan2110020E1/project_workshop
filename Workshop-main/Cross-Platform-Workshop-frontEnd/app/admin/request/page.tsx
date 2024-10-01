'use client'
import React, { useEffect, useState } from 'react';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import { Button, Container, Table } from 'react-bootstrap';
import StickIcon from '@mui/icons-material/EmojiFlags';
import { BiCheckCircle, BiXCircle } from 'react-icons/bi';
interface RequestData {
    id: number;
    type: string;
    full_name: string;
    roles: string[];
    createDate: string;
    endDate: string;
    status: string;

}

const RequestPage  = () => {
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    const [requests, setRequests] = useState<RequestData[]>([]);

    useEffect(() => {
        if (session) {
            const fetchData = async () => {
                try {
                    const listRequestResponse = await apiService.listRequestAdmin();
                    if (listRequestResponse.data) {
                        setRequests(listRequestResponse.data);
                    }
                } catch (error) {
                    console.error("Error fetching request:", error);
                }
            };
            fetchData();
        }
    }, [session]);


    return (
        <Container>
            <h1 className='text-center text-white'>Request Page</h1>
            {requests.length > 0 && (
                <Table striped bordered hover className="border border-warning rounded-circle">
                    <thead>
                        <tr className='text-center align-middle'>
                            <th>Request Name</th>
                            <th>Teachers</th>
                            <th>Create Date</th>
                            <th>End Date</th>
                            <th className='pd-2'>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody className='text-center align-middle'>
                        {requests.map((request) => (
                            <tr key={request.id}>
                                <td>{request.type}</td>
                                <td>{request.full_name}</td>
                                <td>{request.createDate}</td>
                                <td>{request.endDate}</td>
                                <td>{request.status ?
                                    (
                                        <i>Completed<BiCheckCircle color="green" size={20} /></i>
                                    ) : (
                                        <i>Prepared<BiXCircle color="red" size={20} /></i>
                                    )
                                    }
                                </td>
                            </tr>
                        ))}
                    </tbody>
                </Table>
            )}
        </Container>
    );
};

export default RequestPage;
