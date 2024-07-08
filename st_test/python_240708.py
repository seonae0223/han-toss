# -*- coding:utf-8 -*-

import streamlit as st 
import pandas as pd 
import matplotlib.pyplot as plt 
import seaborn as sns 
import plotly 
import numpy as np 
import streamlit.components.v1 as components # JavaScript 개발용


@st.cache_data
# Streamlit에서 가져와야 하는 데이터 파일은 가공된 파일이어야 한다.
# 원본 데이터 => 가공 => 다른 파일로 변환 
# 이렇게 다른 파일로 변환된 것을 Streamlit에서 가져오게 됨.
def get_data():
    #data = pd.read_csv("train.csv").head(10) -> Size가 크면 Streamlit에서 작동 안됨
    data = sns.load_dataset("tips")
    return data

def main():
    st.title("Hello Streamlit World!")
    st.write("streamlit version:", st.__version__)
    st.write("pandas version:", pd.__version__)
    st.write("seaborn version:", sns.__version__)
    st.write("numpy version:", np.__version__)

    tips = get_data()
    st.dataframe(tips, use_container_width = True)

    # Streamlit 기본 UI가 맘에 들지 않음 -> 커스텀화 할 생각
    # 그냥 django of flask 웹 개발 프레임워크로 개발하는 것이 좋음.
    
  

    st.markdown("HTML JS Streamlit 적용")
    js_code = """ 
    <h3>Hi</h3>

    <script>
    function sayHello() {
        alert('Hello from JavaScript in Streamlit Web');
    }
    </script>

    <button onclick="sayHello()">Click me</button>
    """
    components.html(js_code)

    tip_max = tips['tip'].max()
    tip_min = tips['tip'].min()

    st.metric(label = "Tip 최대값", value = tip_max)
    st.metric(label = "Tip 최소값", value = tip_min)

    # matplotlib & seaborn
    fig, ax = plt.subplots()
    ax.set_title("Hello World!")
    ax.boxplot(data=tips, x = 'total_bill')
    st.pyplot() #plt.show()

if __name__ == "__main__":
    main()
