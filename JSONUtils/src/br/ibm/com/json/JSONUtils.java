package br.ibm.com.json;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.SortedMap;
import java.util.StringTokenizer;
import java.util.TreeMap;

import br.ibm.com.json.api.JSONArray;
import br.ibm.com.json.api.JSONException;
import br.ibm.com.json.api.JSONObject;

/*
 *
 * IBM Confidential
 *
 * OCO Source Materials
 *
 * 5724-R46
 *
 * (C) COPYRIGHT IBM CORP. 2006,2007
 *
 * The source code for this program is not published or otherwise
 * divested of its trade secrets, irrespective of what has been
 * deposited with the U.S. Copyright Office.
 *
 */
/**
 * @author rbrossi Just a test to read a Json file
 * @version 1.0
 */
public class JSONUtils {

	/**
	 * @param args
	 */

	public JSONUtils() {
		String json = getJsonFromURL("http://localhost:8399/arcgis/rest/services/maximoIIsde/MapServer?f=pjson");
		System.out.println(getLayersFromJson(json));
	}

	public static void main(String[] args) {
		JSONUtils o = new JSONUtils();
	}

	/**
	 * Get the content of a json from a URL
	 * 
	 * @param url
	 *            of the MapService
	 * @return String containing the content of the json file
	 */
	public String getJsonFromURL(String url) {
		return getContentFromURL(url);
	}

	/**
	 * Return a String with the GET content for the URL
	 * 
	 * @param url
	 * @return String with the content of the URL request
	 */
	public String getContentFromURL(String url) {
		URL urlObject = null;
		URLConnection con = null;
		StringBuffer str = new StringBuffer("");
		String strT = "";
		try {
			urlObject = new URL(url);
			con = urlObject.openConnection();
			InputStream content = (InputStream) con.getInputStream();
			BufferedReader in = new BufferedReader(new InputStreamReader(
					content));

			while ((strT = in.readLine()) != null) {
				str.append(strT);
			}

			in.close();

		} catch (MalformedURLException e1) {
			e1.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return str.toString();

	}

	/**
	 * Return a string with a content of a Json file
	 * 
	 * @param path
	 *            Path of the json file
	 * @return String containing the content of the json file
	 */
	public String getJsonFromFile(String path) {
		// TODO Implement this method for maximo utilization
		return null;
	}

	/**
	 * Return a HashMap<String,String> with the Layers Id (as the Key) and name
	 * (as value).
	 * 
	 * @param json
	 * @return HashMap
	 */
	public HashMap<Integer, String> getLayersFromJsonInHashMap(String json) {
		Map<Integer, String> layers = null;
		try {
			if (json == null)
				return null;

			JSONObject obj = new JSONObject(json);
			if (obj != null)
				layers = new HashMap<Integer, String>();
			else
				return null;

			JSONArray array = obj.getJSONArray("layers");
			layers = getLayersFromJson((HashMap) layers, array, "", 0);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return (HashMap<Integer, String>) layers;

	}

	public HashMap<Integer, String> getLayersFromJson(HashMap map,
			JSONArray array, String path, int j) throws JSONException {
		boolean leaf = false;
		HashMap allLayers = new HashMap();

		for (int i = j; i < array.length(); i++) {
			JSONObject layerObject = array.getJSONObject(i);
			String containsLayers = layerObject.getString("subLayerIds");

			String leafName = getString(layerObject, "name");
			String id = getString(layerObject, "id");
			String parentId = getString(layerObject, "parentLayerId");

			allLayers.put(id, leafName);
			if (containsLayers.equals("null")) {
				map.put(id, leafName);
				System.out.println(" id: " + id + " name: " + leafName
						+ " path: " + path);
				leaf = true;
			} else {
				if (leaf) {
					path = getString(layerObject, "name") + "\\";
					leaf = false;
				} else {
					path = path + getString(layerObject, "name") + "\\";

				}
			}
		}
		return map;
	}

	public SortedMap<Integer, MapServiceLayerBean> getLayersFromJson(String json) {
		SortedMap<Integer, MapServiceLayerBean> layers = null;
		HashMap<Integer, MapServiceLayerBean> allLayers = new HashMap<Integer, MapServiceLayerBean>();
		try {
			if (json == null)
				return null;

			JSONObject obj = new JSONObject(json);
			if (obj != null) {
				layers = new TreeMap<Integer, MapServiceLayerBean>(
						new Comparator<Integer>() {

							public int compare(Integer id1, Integer id2) {
								return (id1.compareTo(id2)) * -1;
							}

						});
			} else
				return null;

			JSONArray array = obj.getJSONArray("layers");

			if (array == null)
				return null;

			String group = "";
			int arrayLength = array.length();
			int groupLevel = 0;

			for (int i = 0; i < arrayLength; i++) {
				JSONObject layerObject = array.getJSONObject(i);
				String name = getString(layerObject, "name");
				String parentId = getString(layerObject, "parentLayerId");
				String id = getString(layerObject, "id");
				String subLayerIds = layerObject.getString("subLayerIds");

				MapServiceLayerBean mapSrvLayer = new MapServiceLayerBean();
				mapSrvLayer.setLayerID(new Integer(id));
				mapSrvLayer.setLayerName(name);
				mapSrvLayer.setParentId(new Integer(parentId));
				mapSrvLayer.setSublayersId(this.getSublayersIds(subLayerIds));
				allLayers.put(new Integer(id), mapSrvLayer);
			}

			Iterator<Integer> all = allLayers.keySet().iterator();

			while (all.hasNext()) {
				MapServiceLayerBean layer = allLayers.get(all.next());

				if (layer.getSublayersId().length == 0) {
					layer.setLayerGroup(this.getGroupLayer(allLayers, layer
							.getParentId()));
					layers.put(layer.getLayerID(), layer);
					System.out.println("[DEBUG]:id: "+layer.getLayerID()+" name: "+layer.getLayerName()+ " group: "+layer.getLayerGroup()  );
				}
			}

		} catch (JSONException e) {
			e.printStackTrace();
		}
		return layers;
	}

	private String getGroupLayer(
			HashMap<Integer, MapServiceLayerBean> allLayers, Integer parentId) {

		String groupPath = "";
		if (parentId == -1)
			return "";

		while (parentId != -1) {
			MapServiceLayerBean obj = allLayers.get(parentId);
			groupPath =  obj.getLayerName() + "\\" + groupPath;
			parentId = obj.getParentId();
		}

		return groupPath;
	}

	public Integer[] getSublayersIds(String sublayersIds) {
		ArrayList<Integer> elements = new ArrayList<Integer>();
		StringTokenizer st = new StringTokenizer(sublayersIds, "[,]");
		while (st.hasMoreTokens()) {
			String element = st.nextToken();
			if (!element.equals("null")) {
				elements.add(new Integer(element));
			}
		}
		return (Integer[]) elements.toArray(new Integer[elements.size()]);
	}

	/**
	 * @param layerObject
	 * @param field
	 * @return
	 * @throws JSONException
	 */
	private String getString(JSONObject layerObject, String field)
			throws JSONException {
		return (layerObject.getString(field) == null) ? "" : layerObject
				.getString(field);
	}

}
