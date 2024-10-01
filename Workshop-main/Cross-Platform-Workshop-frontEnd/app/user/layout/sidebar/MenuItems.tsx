import {
  IconBoxMultiple, IconCircleDot,IconMoneybag, IconHome, IconInfoCircle, IconLayout, IconLayoutGrid, IconPhoto, IconPoint, IconStar, IconTable, IconUser
} from "@tabler/icons-react";

import { uniqueId } from "lodash";

const Menuitems = [
  {
    id: uniqueId(),
    title: "Workshop",
    icon: IconCircleDot,
    href: "/user/ui-components/buttons",
  },
  {
    id: uniqueId(),
    title: "Forms",
    icon: IconTable,
    href: "/user/ui-components/forms",
  },

  {
    id: uniqueId(),
    title: "Deposit",
    icon: IconMoneybag,
    href: "/user/ui-components/images",
  },

];

export default Menuitems;
