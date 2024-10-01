import {
  IconBoxMultiple,IconPigMoney, IconCircleDot , IconHome, IconInfoCircle, IconLayout, IconLayoutGrid, IconPhoto, IconPoint, IconStar, IconTable, IconUser
} from "@tabler/icons-react";

import { uniqueId } from "lodash";

const Menuitems = [
  {
    id: uniqueId(),
    title: "Workshop",
    icon: IconCircleDot,
    href: "/teacher/ui-components/buttons",
  },
  {
    id: uniqueId(),
    title: "Forms",
    icon: IconTable,
    href: "/teacher/ui-components/forms",
  },

  {
    id: uniqueId(),
    title: "Withdrawal",
    icon: IconPigMoney ,
    href: "/teacher/ui-components/images",
  },

];

export default Menuitems;
