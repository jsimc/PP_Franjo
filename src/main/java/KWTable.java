import java.util.HashMap;

public class KWTable {

	private HashMap<String, Integer> mTable;
	public KWTable()
	{
		// Inicijalizcaija hash tabele koja pamti kljucne reci
		mTable = new HashMap<>();
		mTable.put("FRANJO", sym.FRANJO);
		mTable.put("TUDJMAN", sym.TUDJMAN);

		mTable.put("main", sym.MAIN);
		mTable.put("declare", sym.DECLARE);
		mTable.put("default", sym.DEFAULT);
		mTable.put("case", sym.CASE);

		mTable.put("int", sym.INT);
		mTable.put("char", sym.CHAR);
		mTable.put("float", sym.FLOAT);
		mTable.put("bool", sym.BOOL);
		mTable.put("string", sym.STRING);
		mTable.put("true", sym.CONST);
		mTable.put("false", sym.CONST);
	}
	
	/**
	 * Vraca ID kljucne reci 
	 */
	
	public int find(String keyword)
	{
		Object symbol = mTable.get(keyword);
		if (symbol != null)
			return ((Integer)symbol).intValue();
		
		// Ako rec nije pronadjena u tabeli kljucnih reci radi se o identifikatoru
		return sym.ID;
	}
	

}
