'use client';
import styles from '../alerts/chat.module.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faHome,faUser, faPencil, faCommenting, faFile, faCog } from '@fortawesome/free-solid-svg-icons';

const Alerts = () => {
    return (
        <div className={`${styles.containerCustom} container`}>
            <div className={`${styles.rowCustom} row`}>
                <nav className={styles.menu}>
                    <ul className={styles.items}>
                        <li className={styles.item}>
                        <FontAwesomeIcon icon={faHome} />
                        </li>
                        <li className={styles.item}>
                        <FontAwesomeIcon icon={faUser} />
                        </li>
                        <li className={styles.item}>
                        <FontAwesomeIcon icon={faPencil} />
                        </li>
                        <li className="item item-active">
                        <FontAwesomeIcon icon={faCommenting} />
                        </li>
                        <li className={styles.item}>
                        <FontAwesomeIcon icon={faFile} />
                        </li>
                        <li className={styles.item}>
                        <FontAwesomeIcon icon={faCog} />
                        </li>
                    </ul>
                </nav>

                <section className={styles.discussions}>
                    <div className={styles.discussionSearch}>
                        <div className={styles.searchbar}>
                            <i className="fa fa-search" aria-hidden="true"></i>
                            <input type="text" placeholder="Search..." />
                        </div>
                    </div>

                    <div className={styles.messageActive}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80)' }}>
                            <div className={styles.online}></div>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.descContactName}>Megan Leib</p>
                            <p className={styles.descContactMessage}>9 pm at the bar if possible 😳</p>
                        </div>
                        <div className={styles.descContactTimer}>12 sec</div>
                    </div>

                    <div className={styles.discussion}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://i.pinimg.com/originals/a9/26/52/a926525d966c9479c18d3b4f8e64b434.jpg)' }}>
                            <div className={styles.online}></div>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.name}>Dave Corlew</p>
                            <p className={styles.message}>Let's meet for a coffee or something today ?</p>
                        </div>
                        <div className={styles.timer}>3 min</div>
                    </div>
                    <div className={styles.discussion}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1497551060073-4c5ab6435f12?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=667&q=80)' }}>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.name}>Jerome Seiber</p>
                            <p className={styles.message}>I've sent you the annual report</p>
                        </div>
                        <div className={styles.timer}>42 min</div>
                    </div>

                    <div className={styles.discussion}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://card.thomasdaubenton.com/img/photo.jpg)' }}>
                            <div className={styles.online}></div>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.name}>Thomas Dbtn</p>
                            <p className={styles.message}>See you tomorrow ! 🙂</p>
                        </div>
                        <div className={styles.timer}>2 hour</div>
                    </div>

                    <div className={styles.discussion}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1553514029-1318c9127859?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80)' }}>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.name}>Elsie Amador</p>
                            <p className={styles.message}>What the f**k is going on ?</p>
                        </div>
                        <div className={styles.timer}>1 day</div>
                    </div>

                    <div className={styles.discussion}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1541747157478-3222166cf342?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=967&q=80)' }}>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.name}>Billy Southard</p>
                            <p className={styles.message}>Ahahah 😂</p>
                        </div>
                        <div className={styles.timer}>4 days</div>
                    </div>

                    <div className={styles.discussion}>
                        <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1435348773030-a1d74f568bc2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1050&q=80)' }}>
                            <div className={styles.online}></div>
                        </div>
                        <div className={styles.descContact}>
                            <p className={styles.name}>Paul Walker</p>
                            <p className={styles.message}>You can't see me</p>
                        </div>
                        <div className={styles.timer}>1 week</div>
                    </div>

                </section>
                <section className={styles.chat}>
                    <div className={styles.headerChat}>
                        <i className="icon fa fa-user-o" aria-hidden="true"></i>
                        <p className={styles.headerChatName}>Megan Leib</p>
                        <i className={`icon clickable fa fa-ellipsis-h ${styles.right}`} aria-hidden="true"></i>
                    </div>
                    <div className={styles.messagesChat}>
                        <div className={styles.message}>
                            <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80)' }}>
                                <div className={styles.online}></div>
                            </div>
                            <p className={styles.text}> Hi, how are you ? </p>
                        </div>
                        <div className={`${styles.message} ${styles.textOnly}`}>
                            <p className={styles.text}> What are you doing tonight ? Want to go take a drink ?</p>
                        </div>
                        <p className={styles.time}> 14h58</p>
                        <div className={`${styles.message} ${styles.textOnly}`}>
                            <div className={styles.response}>
                                <p className={styles.responseText}> Hey Megan ! It's been a while 😃</p>
                            </div>
                        </div>
                        <div className={`${styles.message} ${styles.textOnly}`}>
                            <div className={styles.response}>
                                <p className={styles.responseText}> When can we meet ?</p>
                            </div>
                        </div>
                        <p className={`${styles.responseTime} ${styles.time}`}> 15h04</p>
                        <div className={styles.message}>
                            <div className={styles.photo} style={{ backgroundImage: 'url(https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80)' }}>
                                <div className={styles.online}></div>
                            </div>
                            <p className={styles.text}> 9 pm at the bar if possible 😳</p>
                        </div>
                        <p className={styles.time}> 15h09</p>
                    </div>
                    <div className={styles.footerChat}>
                        <i className={`icon fa fa-smile-o clickable`} style={{ fontSize: '25pt' }} aria-hidden="true"></i>
                        <input type="text" className={styles.writeMessage} placeholder="Type your message here"></input>
                        <i className={`icon send fa fa-paper-plane-o clickable`} aria-hidden="true"></i>
                    </div>
                </section>

            </div>
        </div>

    );
};

export default Alerts;
