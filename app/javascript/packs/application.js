import "bootstrap";
import { initSelect2 } from '../plugins/init_select2';


initSelect2();

import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';

initMapbox();
